import json
import pickle

__locations = None
__data_columns=None
__model=None


def get_location_name():
    return __locations

def load_saved_artefacts():
    print('loading saved artifacts...start')
    global __data_columns
    global __locations

    with open("./artifacts/columns.json","r") as f:
        __data_columns = json.load(f)['data_columns']
        __locations = __data_columns[3:]

    with open("./artifacts/house_price_hautegar_model.pickle","rb") as f:
        __model = pickle.load(f)
