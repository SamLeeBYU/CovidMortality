import pandas as pd
import requests

Data = pd.DataFrame()

token = None
data = pd.DataFrame()

with open('../Data/hud.txt', 'r') as file:
    token = file.readline().strip()
    
for q in range(1, 4+1):    
    url = f"https://www.huduser.gov/hudapi/public/usps?type=2&year=2021&quarter={q}&query=All"
    headers = {"Authorization": "Bearer {0}".format(token)}

    response = requests.get(url, headers = headers)

    if response.status_code != 200:
        print ("Failure, see status code: {0}".format(response.status_code))
        break
    else: 
        data = pd.DataFrame(response.json()["data"]["results"])
        data["quarter"] = q
        if Data.empty:
            Data = data.copy()
        else:
            Data = pd.concat([Data, data])

#Geoid = County
Data[["zip", "geoid", "city", "state", "quarter"]].to_csv("../Data/zip-county.csv", index=False)