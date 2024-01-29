// alpinejs@3.13.5/_/a-e61HbN.js downloaded from https://ga.jspm.io/npm:alpinejs@3.13.5/_/a-e61HbN.js

function debounce(t,e){var n;return function(){var u=this,o=arguments;var later=function(){n=null;t.apply(u,o)};clearTimeout(n);n=setTimeout(later,e)}}function throttle(t,e){let n;return function(){let u=this,o=arguments;if(!n){t.apply(u,o);n=true;setTimeout((()=>n=false),e)}}}export{debounce as d,throttle as t};

