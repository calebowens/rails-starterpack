// alpinejs@3.13.5/src/utils/error.js downloaded from https://ga.jspm.io/npm:alpinejs@3.13.5/src/utils/error.js

function tryCatch(r,e,n,...o){try{return n(...o)}catch(n){handleError(n,r,e)}}function handleError(r,e,n=void 0){r=Object.assign(r??{message:"No error message given."},{el:e,expression:n});console.warn(`Alpine Expression Error: ${r.message}\n\n${n?'Expression: "'+n+'"\n\n':""}`,e);setTimeout((()=>{throw r}),0)}export{handleError,tryCatch};

