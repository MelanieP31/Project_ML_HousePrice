from flask import Flask, request, jsonify
import util
app = Flask(__name__)

@app.route('/get_locations', methods=['GET'])
def get_locations():
    response = jsonify({
        'locations': util.get_location_name()
    })
    response.headers.add('Access-Control-Allow-Origin','*')
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



if __name__ == "__main__":
    util.load_saved_artefacts()
    app.run(debug=True)
