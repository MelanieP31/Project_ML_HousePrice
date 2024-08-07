from flask import Flask, request, jsonify
from flask_cors import CORS
import util

app = Flask(__name__)
CORS(app)

@app.route('/get_locations', methods=['GET'])
def get_locations():
    response = jsonify({
        'locations': util.get_location_name()
    })
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

@app.route('/predict_price', methods=['POST'])
def predict_price():
    try :
        data = request.get_json()
        location = data['location']
        surface_reelle_bati = int(data['surface_reelle_bati'])
        nombre_pieces_principales = int(data['nombre_pieces_principales'])
        surface_terrain = float(data['surface_terrain'])

        estimated_price = util.get_estimated_price(location, surface_reelle_bati, nombre_pieces_principales, surface_terrain)
        response = jsonify({
            'estimated_price': estimated_price
        })
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response
    except Exception as e:
        print(f"Error: {e}")
        response = jsonify({
            'error': str(e)
        })
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response, 500

@app.route('/mean_price_data', methods=['GET'])
def mean_price_data():
    try:
        data = util.get_mean_price_data()
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response
    except Exception as e:
        print(f"Error: {e}")
        response = jsonify({
            'error': str(e)
        })
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response, 500


@app.route('/get_postal_data', methods=['GET'])
def get_postal_data():
    try:
        postal_code = request.args.get('postal_code')
        data = util.get_postal_data(postal_code)
        response = jsonify(data)
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response
    except Exception as e:
        print(f"Error: {e}")
        response = jsonify({
            'error': str(e)
        })
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response, 500

if __name__ == "__main__":
    util.load_saved_artefacts()
    app.run(debug=True)
