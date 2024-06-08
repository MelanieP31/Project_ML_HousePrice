import json
import pickle
import numpy as np

__locations = None
__data_columns=None
__model=None

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
    return __locations

def load_saved_artefacts():
    print('loading saved artifacts...start')
    global __data_columns
    global __locations

    with open("./artifacts/columns.json", "r") as f:
        __data_columns = json.load(f)['data_columns']
        __locations = __data_columns[3:]

    global __model
    with open("./artifacts/house_price_hautegar_model.pickle","rb") as f:
        __model = pickle.load(f)

if __name__ == '__main__' :
    load_saved_artefacts()
    print(get_location_name())
    print(get_estimated_price("code_postal_31100",100,2,0))
