from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

# Load the model
file_path = "random_forest_model.pkl"  # Path to the model file
with open(file_path, 'rb') as file:
    model = pickle.load(file)

# Define a route for the home page
@app.route('/')
def home():
    return "Welcome to the ML Prediction API!"

# Define the prediction route
@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json

        if 'features' not in data or not isinstance(data['features'], list):
            return jsonify({"error": "Invalid input: 'features' key is required and must be a list."}), 400

        features = data['features']  # Extract the features

        if len(features) != 5:  # Adjust this if your model requires a different number of features
            return jsonify({"error": f"Invalid number of features: expected 5, got {len(features)}."}), 400

        features = np.array(features).reshape(1, -1)

        # Make the prediction
        predictions = model.predict(features)

        predictions = predictions.astype(int).tolist()  # Ensure the predictions are in list format of integers

        return jsonify({'predictions': predictions})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)



