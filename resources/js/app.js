import './bootstrap';

import Alpine from 'alpinejs';

window.Alpine = Alpine;

Alpine.start();

import TomSelect from "tom-select";
import 'tom-select/dist/css/tom-select.bootstrap5.min.css'; // Or another theme if you prefer
window.TomSelect = TomSelect;
