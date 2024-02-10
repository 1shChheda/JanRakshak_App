// Function to calculate distance between two points using Haversine formula
function calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371.0; // Radius of the Earth in kilometers
  
    // Convert latitude and longitude from degrees to radians
    const lat1Rad = toRadians(lat1);
    const lon1Rad = toRadians(lon1);
    const lat2Rad = toRadians(lat2);
    const lon2Rad = toRadians(lon2);
  
    // Calculate the change in coordinates
    const dLon = lon2Rad - lon1Rad;
    const dLat = lat2Rad - lat1Rad;
  
    // Apply Haversine formula
    const a = Math.sin(dLat / 2) ** 2 + Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.sin(dLon / 2) ** 2;
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c;
  
    return distance;
  }
  
  // Helper function to convert degrees to radians
  function toRadians(degrees) {
    return degrees * Math.PI / 180;
  }
  
  // Current coordinates
  const currentLatitude = 19.1232;
  const currentLongitude = 72.836;
  
  // Coordinates of hospitals
  const hospitalCoordinates = {
    "City Multispeciality Hospital": [19.14468676, 72.84273082],
    "SBS Multi-Speciality Hospital": [19.13803777, 72.83586437],
    "Mallika Hospital": [19.13946505, 72.84696226],
    "Bellevue Multispeciality Hospital": [19.13119405, 72.83211356],
    "KJ CURE HOSPITAL": [19.13143732, 72.84730559],
    "Criticare Asia Multispeciality Hospital & Research Centre- 24/7 Emergency Cashless Hospital in Andheri East": [19.11943554, 72.85030966],
    "Ark Hospital": [19.11748922, 72.83546095],
    "KLS Memorial Hospital": [19.10946042, 72.84103995],
    "Advanced Multispeciality Hospital": [19.11116353, 72.83717757],
    "Shalyak Hospital": [19.13905962, 72.85442953],
    "Four Care Hospital": [19.10321552, 72.85133963],
    "Nanavati Max Super Speciality Hospital": [19.09770036, 72.84026747],
    "Holy Spirit Hospital": [19.13244774, 72.86579873],
    "Kokilaben Dhirubhai Ambani Hospital and Medical Research Institute": [19.13231597, 72.82499707],
    "Nakshatra Hospital": [19.12404, 72.83227]
  };
  // Create an array to store objects with hospital data
  const hospitalsData = [];
  
  // Calculate distances for each hospital and store data in the array
  for (const [hospital, coordinates] of Object.entries(hospitalCoordinates)) {
    const distance = calculateDistance(currentLatitude, currentLongitude, coordinates[0], coordinates[1]);
    hospitalsData.push({
        hospitalName: hospital,
        distance: distance.toFixed(2),
        latitude: coordinates[0],
        longitude: coordinates[1]
    });
  }
  
  // Sort hospitalsData array by distance
  hospitalsData.sort((a, b) => a.distance - b.distance);
  
  // Add ranks to the sorted array
  const rankedHospitalsData = hospitalsData.map((hospital, index) => ({
    rank: index + 1,
    hospitalName: hospital.hospitalName,
    distance: hospital.distance,
    latitude: hospital.latitude,
    longitude: hospital.longitude
  }));
  
  // Print or use the rankedHospitalsData array as needed
  console.log(rankedHospitalsData);
  