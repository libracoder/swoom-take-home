const express = require('express')
require('dotenv').config()
var AWS = require('aws-sdk');
const app = express()
const port = 3000
AWS.config.update({ "accessKeyId":  process.env.AWS_ACCESS_KEY_ID, "secretAccessKey": process.env.AWS_SECRET_ACCESS_KEY, "region": process.env.AWS_REGION });

s3 = new AWS.S3({apiVersion: '2006-03-01'});
let params = {
    Bucket: process.env.BUCKET_NAME,
    Delimiter: '/',
};
app.get('/', (req, res) => {
    s3.listObjects(params,function (err, data) {
        if (err) {
            console.log('There was an error viewing your album: ' + err.message)
            return res.json({status:process.env.BUCKET_NAME, message:'There was an error viewing your album: ' + err.message,data:null})
        } else {
            var items=[]
            let items_payload = data.Contents;
            items_payload.forEach((item)=>{
                items.push({
                    name:item.Key
                })
            })

            return res.json({status:"success", message:"bucket items retrieved sucessfully", data:items})
        }
    })
})

app.listen(port, () => {
    console.log(process.env)
    console.log(`Example app listening at http://localhost:${port}`)
})


