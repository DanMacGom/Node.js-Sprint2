const MongoClient = require("mongodb").MongoClient;
const url = "mongodb://localhost:27017";

MongoClient.connect(url, function(err, client) {
  if (err) {
    throw err;
  }

  const args = process.argv;
  let arg = "";

  if (args.length === 3 && args[2] < 33) {
    arg = args[2];
  } else if (args[2] >= 33 || args[2] < 0) {
    throw "Exercise number does not exist.";
  }

  const db = client.db("restaurants");
  console.log(`Connected to ${url}`);

  const restaurantsCol = db.collection("restaurantsCollection");

  // 1. Escriu una consulta per mostrar tots els documents en la col·lecció
  // Restaurants.
  if (arg === "1" || arg === "") {
    restaurantsCol
    .find({})
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 2. Escriu una consulta per mostrar el restaurant_id, name, borough i
  // cuisine per tots els documents en la col·lecció Restaurants.
  if (arg === "2" || arg === "") {
    restaurantsCol
    .find({},
      { projection: { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result)
    })
  }

  // 3. Escriu una consulta per mostrar el restaurant_id, name, borough i
  // cuisine, però excloure el camp _id per tots els documents en la col·lecció.
  // Restaurants
  if (arg === "3" || arg === "") {
    restaurantsCol
    .find({},
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 4. Escriu una consulta per mostrar restaurant_id, name, borough i zip code,
  // però excloure el camp _id per tots els documents en la col·lecció Restaurants.
  if (arg === "4" || arg == "") {
    restaurantsCol
    .find({},
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, address: { zipcode: 1 } } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 5. Escriu una consulta per mostrar tot els restaurants que estan en el Bronx.
  if (arg === "5" || arg === "") {
    restaurantsCol
    .find({ borough: "Bronx" })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 6. Escriu una consulta per mostrar els primers 5 restaurants que estan en el Bronx.
  if (arg === "6" || arg === "") {
    restaurantsCol
    .find({ borough: "Bronx" }).limit(5)
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 7. Escriu una consulta per mostrar el pròxim 5 restaurants després de saltar.
  // els primers 5 del Bronx
  if (arg === "7" || arg === "") {
    restaurantsCol
    .find({ borough: "Bronx" })
    .skip(5)
    .limit(5)
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 8. Escriu una consulta per trobar els restaurants que tenen un score de més de 90.
  if (arg === "8" || arg === "") {
    restaurantsCol
    .find({ grades: { $elemMatch: { score: { $gt: 90 } } } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 9. Escriu una consulta per trobar els restaurants que tenen un score de més que 80 però menys que 100.
  if (arg === "9" || arg === "") {
    restaurantsCol
    .find({ grades: { $elemMatch: { score: { $gt: 80, $lt: 100 } } } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 10. Escriu una consulta per trobar els restaurants quins localitzen en valor de
  // latitud menys que -95.754168.
  if (arg === "10" || arg === "") {
    restaurantsCol
    .find({ "address.coord.0": { $lt: -95.754168 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 11. Escriu una consulta de MongoDB per a trobar els restaurants que no preparen cap cuisine
  // de 'American' i el seu puntaje de qualificació superior a 70 i latitud inferior a -65.754168.
  if (arg === "11" || arg === "") {
    restaurantsCol
    .find({
      grades: { $elemMatch: { score: { $gt: 70 } } },
      cuisine: { $ne: "American" },
      "address.coord.0": { $lt: -65.754168 }
    })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 12. Escriu una consulta per trobar els restaurants quins no preparen cap cuisine
  // de 'American' i va aconseguir un marcador més que 70 i localitzat en la longitud menys
  // que -65.754168. Nota : Fes aquesta consulta sense utilitzar $and operador.
  if (arg === "12" || arg === "") {
    restaurantsCol
    .find({
      grades: { $elemMatch: { score: { $gt: 70 } } },
      cuisine: { $ne: "American" },
      "address.coord.0": { $lt: -65.754168 }
    })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 13. Escriu una consulta per trobar els restaurants quins no preparen cap cuisine de
  // 'American' i va aconseguir un punt de grau 'A' no pertany a Brooklyn. S'ha de
  // mostrar el document segons la cuisine en ordre descendent.
  if (arg === "13" || arg === "") {
    restaurantsCol
    .find({
      grades: { $elemMatch: { grade: "A" } },
      cuisine: { $ne: "American" },
      borough: { $ne: "Brooklyn" }
    })
    .sort({ cuisine: 1 })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 14. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants quin contenir 'Wil' com les tres primeres lletres en el seu nom.
  if (arg === "14" || arg === "") {
    restaurantsCol
    .find(
      { name: { $regex: /^Wil/i } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } }
    )
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 15. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants quin contenir 'ces' com les últim tres lletres en el seu nom.
  if (arg === "15" || arg === "") {
    restaurantsCol
    .find(
      { name: { $regex: /ces$/ } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 16. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants quin contenir 'Reg' com tres lletres en algun lloc en el seu nom.
  if (arg === "16" || arg === "") {
    restaurantsCol
    .find(
      { name: { $regex: /Reg/ } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 17. Escriu una consulta per trobar els restaurants quins pertanyen al Bronx
  // i va preparar qualsevol plat American o xinès.
  if (arg === "17" || arg === "") {
    restaurantsCol
    .find({
      borough: "Bronx",
      $or: [ { cuisine: "American"}, { cuisine: "Chinese"} ]
    })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 18. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants que pertanyen a Staten Island o Queens o Bronxor Brooklyn.
  if (arg === "18" || arg === "") {
    restaurantsCol
    .find(
      { borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 19. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants que no pertanyen a Staten Island o Queens o Bronxor Brooklyn.
  if (arg === "19" || arg === "") {
    restaurantsCol
    .find(
      { borough: { $nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 20. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants que aconsegueixin un marcador quin no és més que 10.
  if (arg === "20" || arg === "") {
    restaurantsCol
    .find(
      { grades: { $elemMatch: { score: { $lte: 10 } } } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 21. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine
  // per a aquells restaurants que preparen peix excepte 'American' i 'Chinees'
  // o el name del restaurant comença amb lletres 'Wil'.
  if (arg === "21" || arg === "") {
    restaurantsCol
    .find(
      { $or: [ { name: { $regex: /^Wil/ } }, { cuisine: "Seafood" } ] },
      { projection: { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 22. Escriu una consulta per trobar el restaurant_id, name, i grades per a
  // aquells restaurants que aconsegueixin un grau "A" i un score 11 en dades
  // d'estudi ISODate "2014-08-11T00:00:00Z".
  if (arg === "22" || arg === "") {
    let date = new Date("2014-08-11T00:00:00Z");
    let miliseconds = date.getTime();

    restaurantsCol
    .find(
      {
        grades: { $elemMatch: { grade: "A" } },
        grades: { $elemMatch: { score: 11 } },
        grades: { "date.$date": miliseconds }
      },
      { projection: { _id: 0, restaurant_id: 1, name: 1, grades: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 23. Escriu una consulta per trobar el restaurant_id, name i grades per a
  // aquells restaurants on el 2n element de varietat de graus conté un grau de
  // "A" i marcador 9 sobre un ISODate "2014-08-11T00:00:00Z".
  if (arg === "23" || arg === "") {
    let date = new Date("2014-08-11T00:00:00Z");
    let miliseconds = date.getTime();

    restaurantsCol
    .find(
      {
        "grades.2": { $elemMatch: { grade: "A" } },
        "grades.2": { $elemMatch: { score: 9 } },
        "grades.2": { "date.$date": miliseconds }
      },
      { projection: { _id: 0, restaurant_id: 1, name: 1, grades: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 24. Escriu una consulta per trobar el restaurant_id, name, adreça i ubicació
  // geogràfica per a aquells restaurants on el segon element del array coord conté
  // un valor quin és més que 42 i fins a 52.
  if (arg === "24" || arg === "") {
    restaurantsCol
    .find(
      { "address.coord.1": { $gt: 42, $lt: 52 } },
      { projection: { _id: 0, restaurant_id: 1, name: 1, address: 1, borough: 1 } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 25. Escriu una consulta per organitzar el nom dels restaurants en ordre
  // ascendent juntament amb totes les columnes
  if (arg === "25" || arg === "") {
    restaurantsCol
    .find({})
    .sort({ name: 1 })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 26. Escriu una consulta per organitzar el nom dels restaurants en descendir
  // juntament amb totes les columnes
  if (arg === "26" || arg === "") {
    restaurantsCol
    .find({})
    .sort({ name: -1 })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 27. Escriu una consulta a organitzar el nom de la cuisine en ordre ascendent
  // i per el mateix barri de cuisine. Ordre descendint.
  if (arg === "27" || arg === "") {
    restaurantsCol
    .find({})
    .sort({ cuisine: 1, borough: -1 })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    });
  }

  // 28. Escriu una consulta per saber tant si totes les direccions contenen el
  // carrer o no.
  if (arg === "28" || arg === "") {
    async function division() {
      let dividend = await restaurantsCol
        .countDocuments({ "address.street": { "$exists": true } })

      let divisor = await restaurantsCol
        .countDocuments();

      console.log(`${dividend / divisor * 100}% of restaurants have the street in their address.`);
    }

    division();
  }

  // 29. Escriu una consulta quin seleccionarà tots el documents en la col·lecció de
  // restaurants on el valor del camp coord és Double.
  if (arg === "29" || arg === "") {
    restaurantsCol
    .find({ "address.coord": { $type: "double" } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    })
  }

  // 30. Escriu una consulta quin seleccionarà el restaurant_id, name i grade per a
  // aquells restaurants quins retorns 0 com a resta després de dividir el marcador per 7.
  if (arg === "30" || arg === "") {
    restaurantsCol
    .find({ grades: { $elemMatch: { score: { $mod: [ 7, 0 ] } } } })
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    })
  }

  // 31. Escriu una consulta per trobar el name de restaurant, borough, longitud i altitud
  // i cuisine per a aquells restaurants que contenen 'mon' com tres lletres en algun lloc
  // del seu name.
  if (arg === "31" || arg === "") {
    restaurantsCol
    .find(
      { name: { $regex: /mon/i } },
      { projection: { _id: 0, name: 1, borough: 1, "address.coord": 1, cuisine: 1 } }
    )
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    })
  }

  // 32. Escriu una consulta per trobar el name de restaurant, borough, longitud i
  // latitud i cuisine per a aquells restaurants que conteinen 'Mad' com primeres
  // tres lletres del seu name.
  if (arg === "32" || arg === "") {
    restaurantsCol
    .find(
      { name: { $regex: /^Mad/ } },
      { projection: { _id: 0, name: 1, borough: 1, "address.coord": 1, cuisine: 1 } }
    )
    .toArray(function(err, result) {
      if (err) {
        throw err;
      }

      console.log(result);
    })
  }
});
