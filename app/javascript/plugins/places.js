import 'places.js'

var places = require('places.js');
var placesAutocomplete = places({
  appId: '',
  apiKey: '',
  container: document.querySelector('#address-input')
});
