Estimation House Princing in "Haute Graonne(31)"

-------------
Project Overview 
This project aims to find the best model to estimate the price at which you could sell your house in the "Haute Garonne (31)" department. We utilized data from sold houses in the department, available on data.gouv.fr (https://files.data.gouv.fr/geo-dvf/latest/csv/ ). The dataset includes data from the last 4 years (2021 to 2024).

The model is deployed on an AWS server using a PyFlask Server. Users can enter the location (postal code), the surface area of their house, the number of rooms, and the total land surface (easily found on cadastral maps) to get an estimated price.

Projet : House_price_toulouse : résultats final apres déploiement (AWS) : http://ec2-13-60-51-246.eu-north-1.compute.amazonaws.com/app.html

------------ 
Project Structure

House_price_Toulouse
    Client: Contains HTML, CSS, and JavaScript files for the client-side view.
    
    Data: Contains Jupyter Notebooks (Python code) for data importation, initial cleaning, and merging. This folder also includes CSV files containing the organized data.
    
    Model:
        Jupyter Notebook: 
            * Python scripts for testing and creating the model. This includes reading data, exploring and mapping prices based on location (using the OpenCageData API), and creating a price-by-location dataframe. The final results are exported as mean_price_coordinate.json.
            * Model Training: Different models were explored using GridSearch, including LinearRegression, Lasso, and RandomForestRegression. The best score was achieved with XGBoost, which had an R² score of 0.63, an RMSE of 72,237, and an MAE of 53,494. The final model was trained with all the data and exported as house_price_hautegat_model.pickle.
            * Artifacts:
                house_price_hautegat_model.pickle: The final trained model.
                mean_price_coordinate.json: Mean prices with coordinates for each location.
                columns.json: Columns associated with the model.
    Server:
        * Artifacts: Includes the model and JSON files.
        * server.py: The Flask server script, handling routing and utility method calls.
        * util.py: Various utility methods used by the server.
        
-----------
Deployment
The application is deployed on an AWS server using a PyFlask server. Users can enter the required details to get an estimated price for their house. Link to access the final version : http://ec2-13-60-51-246.eu-north-1.compute.amazonaws.com/app.html

----------------
Model Evaluation
Mean Value: 282,626
Best Model: XGBoost with GridSearch
R² Score: 0.63
RMSE: 72,237
MAE: 53,494

----------------
Future Work
Enhance the model by incorporating additional features.
Improve the user interface for better user experience.

--------------
Feel free to explore the project and provide any feedback. 