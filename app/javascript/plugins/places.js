import 'places.js'
import 'dotenv'

require('dotenv').config();

console.log(process.env);
var places = require('places.js');
var placesAutocomplete = places({
  appId: process.env.ALGOLIA_PLACES_APP_ID,
  apiKey: process.env.ALGOLIA_PLACES_APP_KEY,
  container: document.querySelector('#address-input'),
  templates: {
      value: function(suggestion) {
        return suggestion.name + ", " + suggestion.country
      }
    }
}).configure({
    type: 'city',
    aroundLatLngViaIP: false,
  });

placesAutocomplete.on('change', function(e) {
  $.ajax({
      type: 'POST',
      data: `lat=${e.suggestion.latlng.lat}&lng=${e.suggestion.latlng.lng}`,
      url: `/amadeus_data`,
      success: function(result) {
        console.log(result)
        console.log(result[0])
        document.querySelector('.data').innerText = result[0].iataCode + ": " + result[0].detailedName
      }
  });
});

// https://test.api.amadeus.com/v1/reference-data/locations/pois?latitude=41.397158&longitude=2.160873
// suggestion.latlng.lat
// suggestion.latlng.lng
