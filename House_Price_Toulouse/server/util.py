import json
import pickle
import numpy as np

__locations = None
__data_columns=None
__model=None
__mean_price_data =None

def get_estimated_price(location, surface_reelle_bati, nombre_pieces_principales, surface_terrain) :
    try :
        loc_index = __data_columns.index(location.lower())
    except :
        loc_index = -1

    x = np.zeros(len(__data_columns))
    x[0] = surface_reelle_bati
    x[1] = nombre_pieces_principales
    x[2] = surface_terrain

    if loc_index >= 0:
        x[loc_index] = 1

    return float(round(__model.predict([x])[0],2))

def get_location_name():
    global __locations
    return [loc.split("_")[2] for loc in __locations]

def get_mean_price_data():
    global __mean_price_data
    return __mean_price_data

def get_postal_data(postal_code):
    postal_code_key = f"{postal_code}"
    if postal_code_key in __mean_price_data:
        data = __mean_price_data[postal_code_key]
        return {
            "avg_price_per_sqm": data["price_mcarre"],
            "avg_property_price": data["valeur_fonciere"]
        }
    else:
        return {
            "avg_price_per_sqm": "N/A",
            "avg_property_price": "N/A"
        }

def load_saved_artefacts():
    print('loading saved artifacts...start')
    global __data_columns
    global __locations
    global __model
    global __mean_price_data


    with open("./artifacts/columns.json", "r") as f:
        __data_columns = json.load(f)['data_columns']
        __locations = [x for x in __data_columns if x.startswith("code_postal_")]

    with open("./artifacts/house_price_hautegar_model.pickle","rb") as f:
        __model = pickle.load(f)

    with open("./artifacts/mean_price_coordinate.json","r") as f:
        __mean_price_data = json.load(f)

    print("loading saved artifacts...done")

if __name__ == '__main__' :
    load_saved_artefacts()
    print(get_location_name())
    print(get_estimated_price("code_postal_31100",100,2,0))