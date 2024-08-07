document.addEventListener('DOMContentLoaded',function() {
    function onPageLoad() {
        console.log("document loaded");
        var url = "/api/get_locations";

        fetch(url)
            .then(response => response.json())
            .then(data => {
                console.log("got response for get_location request", data);
                if (data && data.locations) {
                    var locations = data.locations;
                    var uiLocation = document.getElementById("uiLocation");
                    var postalCodeSelect = document.getElementById("postalCode");

                    // Ajout de logs pour vérifier les éléments
                    if (uiLocation) {
                        console.log("uiLocation element found:", uiLocation);
                        uiLocation.innerHTML = '<option value="" disabled selected>Choisissez un code postal</option>';
                    } else {
                        console.error("uiLocation element not found!");
                    }

                    if (postalCodeSelect) {
                        console.log("postalCodeSelect element found:", postalCodeSelect);
                        postalCodeSelect.innerHTML = '<option value="" disabled selected>Choisissez un code postal</option>';
                    } else {
                        console.error("postalCodeSelect element not found!");
                    }

                    locations.forEach(function(location) {
                        console.log("Adding location:", location);
                        var opt1 = new Option(location, location);
                        var opt2 = new Option(location, location);
                        if (uiLocation) {
                            uiLocation.append(opt1);
                        }
                        if (postalCodeSelect) {
                            postalCodeSelect.append(opt2);
                        }
                    });

                    // Vérifier le contenu des menus déroulants après ajout
                    if (uiLocation) {
                        console.log("uiLocation options:", uiLocation.options);
                    }
                    if (postalCodeSelect) {
                        console.log("postalCodeSelect options:", postalCodeSelect.options);
                    }
                }
            })
            .catch(error => {
                console.error("Error fetching locations: ", error);
            });
    }

    function getNumberPiecesValue(){
        var Nbpieces = document.getElementsByName("piece");
        for(var i in Nbpieces){
            if(Nbpieces[i].checked){
                return parseInt(i)+1;
            }
        }
        return -1;
    }

    function onClickedEstimatePrice(){
        console.log("Estimated Price button clicked");
        var surfaceBatiment = document.getElementById("bati");
        var nbPiece = getNumberPiecesValue();
        var surfaceTerrain = document.getElementById("terrain");
        var location = document.getElementById("uiLocation").value;
        var estPrice = document.getElementById("EstimatedPrice");
    
        var data = {
            surface_reelle_bati: parseFloat(surfaceBatiment.value),
            nombre_pieces_principales: nbPiece,
            surface_terrain: parseFloat(surfaceTerrain.value),
            location: location
        };
    
        console.log("Data being sent:", data);
    
        var url = "/api/predict_price";
    
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(data => {
            console.log(data.estimated_price);
            var roundedPrice = parseFloat(data.estimated_price).toFixed(0);
            estPrice.innerHTML = "<h2>" + roundedPrice + " Euros</h2>";
        })
        .catch(error => {
            console.error("Error:", error);
            estPrice.innerHTML = "<h2>Error: " + error.message + "</h2>";
        });
    
    }

    function getPostalCodeData() {
        var postalCode = document.getElementById("postalCode").value;
        var postalUrl = `/api/get_postal_data?postal_code=${postalCode}`;

        fetch(postalUrl)
            .then(response => response.json())
            .then(data => {
                console.log("got response for postal_code_data request");
                document.getElementById("avgPricePerSqM").textContent = data.avg_price_per_sqm + " €";
                document.getElementById("avgPropertyPrice").textContent = data.avg_property_price + " €";
            })
            .catch(error => {
                console.error("Error fetching postal code data: ", error);
            });
    }


    //Initialization map
    var map = L.map('map').setView([43.6045, 1.444], 10);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    // Fetch the mean price data from the Flask server
    fetch('/api/mean_price_data')
        .then(response => response.json())
        .then(meanPriceData => {
            for (var code_postal in meanPriceData) {
                var data = meanPriceData[code_postal];
                if (data.latitude && data.longitude) {
                    var marker = L.marker([data.latitude, data.longitude]).addTo(map);
                    marker.bindPopup(`<h3>Code Postal: ${code_postal}</h3>
                                  <p>Valeur Foncière: ${data.valeur_fonciere} Euros</p>
                                  <p>Prix/m²: ${data.price_mcarre} Euros</p>`);
                }
            }
        })
        .catch(error => console.error('Error fetching mean price data:', error));

    window.onClickedEstimatePrice = onClickedEstimatePrice;
    window.getPostalCodeData = getPostalCodeData;
    window.onload = onPageLoad;


})







