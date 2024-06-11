function onPageLoad() {
    console.log("document loaded");
    var url = "http://127.0.0.1:5000/get_locations";
    
    fetch(url)
        .then(response => response.json())
        .then(data => {
            console.log("got response for get_location request");
            if (data) {
                var locations = data.locations;
                var uiLocation = document.getElementById("uiLocation");
                $('#uiLocation').empty(); // Clear existing options
            
                locations.forEach(function(location) {
                    var parts = location.split("_");
                    var displayText = parts.length > 2 ? parts.slice(2).join("_") : location;
                    var opt = new Option(displayText, location);
                    uiLocation.append(opt);
                });
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

function onClikedEstimatePrice(){
    console.log("Estimated Prive button clicked");
    var surfaceBatiment = document.getElementById("bati");
    var nbPiece = getNumberPiecesValue();
    var surfaceTerrain = document.getElementById("terrain");
    var location = document.getElementById("uiLocation");
    var estPrice = document.getElementById("EstimatedPrice");

    var data = {
        surface_reelle_bati: parseFloat(surfaceBatiment.value),
        nombre_pieces_principales: nbPiece,
        surface_terrain: parseFloat(surfaceTerrain.value),
        location: location.value
    };

    console.log("Data being sent:", data);

    var url = "http://127.0.0.1:5000/predict_price";

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            surface_reelle_bati: parseFloat(surfaceBatiment.value),
            nombre_pieces_principales: nbPiece,
            surface_terrain: parseFloat(surfaceTerrain.value),
            location: location.value
        })
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


window.onload = onPageLoad;