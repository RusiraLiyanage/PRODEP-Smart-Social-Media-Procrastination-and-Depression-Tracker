function writeUpdate(theData){
    //var fs = require('fs');
    var data = JSON.stringify(theData, null, 2);
    return data;
    //return(data);
    //return "yo yo";
    fs.writeFileSync("userResponses/user1.json", data);
}


