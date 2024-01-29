// alpinejs@3.13.5/src/utils/once.js downloaded from https://ga.jspm.io/npm:alpinejs@3.13.5/src/utils/once.js

function once(e,t=(()=>{})){let n=false;return function(){if(n)t.apply(this,arguments);else{n=true;e.apply(this,arguments)}}}export{once};

