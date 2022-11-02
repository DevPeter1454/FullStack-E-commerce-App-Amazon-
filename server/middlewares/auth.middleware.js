/*jshint esversion: 9 */


const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  console.log('hiiiii');
    try {
      const token = req.header("x-auth-token");
      if (!token)
        return res.status(401).json({ msg: "No auth token, access denied" });
  
      const verified = jwt.verify(token, "passwordKey");
      if (!verified)
        return res
          .status(401)
          .json({ msg: "Token verification failed, authorization denied." });
  
      req.user = verified.id;
      req.token = token;
      next();
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  };
// const auth = async (req, res, next) => {
//     console.log('heeeeeeeeeee')
//     const token = req.header("x-auth-token");
//     if(!token){
//         return res.status(401).json({ msg: "No authentication token, authorization denied." });
//     }
//     jwt.verify(token, "password", (err, decoded) => {
//         if(err){
//             res.status(500).json({ error: err.message });
//         }else{
//             if(!decoded){
//                 return res.status(401).json({ msg: "Token verification failed, authorization denied." });
//             }else{
//                 console.log(decoded);
//                 req.user = decoded.id;
//                 console.log(req.user);
//                 req.token = token;
//                 console.log('done');
//                 next();
//             }
//         }
//     });
// };

module.exports = auth;