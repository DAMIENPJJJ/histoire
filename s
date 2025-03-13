<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marseille History Map</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        #map { height: 500px; width: 80%; margin: auto; }
        #search { padding: 10px; margin: 10px; width: 80%; }
        button { padding: 10px; margin: 10px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Carte Interactive des Lieux Historiques de Marseille</h1>
    <input type="text" id="search" placeholder="Rechercher un lieu...">
    <button onclick="getUserLocation()">Obtenir un itinéraire depuis ma position</button>
    <div id="map"></div>
    
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        let map = L.map('map').setView([43.2965, 5.3698], 13);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);

        let places = [
            { name: "Notre-Dame de la Garde", lat: 43.2803, lng: 5.3711 },
            { name: "Vieux-Port", lat: 43.2950, lng: 5.3734 },
            { name: "Stade Vélodrome", lat: 43.2692, lng: 5.3957 }
        ];

        let markers = [];
        places.forEach(place => {
            let marker = L.marker([place.lat, place.lng]).addTo(map)
                .bindPopup(`<b>${place.name}</b><br><button onclick="getDirections(${place.lat}, ${place.lng})">Itinéraire</button>`);
            markers.push(marker);
        });

        function getUserLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => {
                    let userLat = position.coords.latitude;
                    let userLng = position.coords.longitude;
                    L.marker([userLat, userLng]).addTo(map).bindPopup("Votre position").openPopup();
                    alert("Sélectionnez un lieu pour obtenir un itinéraire.");
                }, () => {
                    alert("Impossible d'obtenir votre position.");
                });
            } else {
                alert("La géolocalisation n'est pas supportée par votre navigateur.");
            }
        }

        function getDirections(lat, lng) {
            window.open(`https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}`);
        }
    </script>
</body>
</html>
