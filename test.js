const prompt = require('prompt-sync')();
async function main(){
const name = prompt('What is your name?\n');
console.log(`Hey there ${name}`);
};
main();