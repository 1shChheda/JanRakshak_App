function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371.0;

  const lat1Rad = toRadians(lat1);
  const lon1Rad = toRadians(lon1);
  const lat2Rad = toRadians(lat2);
  const lon2Rad = toRadians(lon2);

  const dLon = lon2Rad - lon1Rad;
  const dLat = lat2Rad - lat1Rad;

  const a = Math.sin(dLat / 2) ** 2 + Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.sin(dLon / 2) ** 2;
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c;

  return distance;
}

function toRadians(degrees) {
  return degrees * Math.PI / 180;
}

function calculateHospitalDistances(currentLatitude, currentLongitude, hospitalData) {
  const hospitalsData = [];

  hospitalData.forEach(hospital => {
    const distance = calculateDistance(currentLatitude, currentLongitude, hospital.lat, hospital.long);
    hospitalsData.push({
      hospitalName: hospital.name,
      distance: distance.toFixed(2),
      latitude: hospital.lat,
      longitude: hospital.long
    });
  });

  hospitalsData.sort((a, b) => a.distance - b.distance);

  const rankedHospitalsData = hospitalsData.map((hospital, index) => ({
    rank: index + 1,
    hospitalName: hospital.hospitalName,
    distance: hospital.distance,
    latitude: hospital.latitude,
    longitude: hospital.longitude
  }));

  return rankedHospitalsData;
}

module.exports = calculateHospitalDistances;
