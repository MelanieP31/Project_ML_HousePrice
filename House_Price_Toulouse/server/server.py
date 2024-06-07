from flask import Flask, request, jsonify
import util
app = Flask(__name__)

@app.route('/get_location_name')
def get_location_name():
    response = jsonify({
        'code_postal': util.get_location_name()
    })
    response.headers.add('Access-Control-Allow-Origin','*')
    return response

if __name__ == "__main__":
    print("Starting Python Flask Server Form Home Price Prediction ...")
    app.run()
