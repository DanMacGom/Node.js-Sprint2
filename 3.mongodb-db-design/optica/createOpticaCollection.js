const MongoClient = require("mongodb").MongoClient;
const url = "mongodb://localhost:27017";

MongoClient.connect(url, function(err, client) {
  if (err) {
    throw err;
  }

  const db = client.db("optica");

  // db.listCollections().toArray(function(err, items) {
  //   if (err) {
  //     throw err;
  //   }
  //
  //   console.log(items.length);
  //   if (items.length !== 0) {
  //     items.forEach(
  //       element => db.collection(element.name).drop(function(err, delOK) {
  //         if (err) {
  //           throw err;
  //         }
  //
  //         if (delOK) {
  //           console.log(`Collection ${element.name} deleted.`)
  //         }
  //       })
  //     )
  //   }
  // });

  console.log(`Connected to ${url}`);

  db.createCollection("products", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: [
          "brand", "left_lens_prescription", "right_lens_prescription",
          "frame_type", "frame_color", "left_lens_color", "right_lens_color",
          "price", "provider"
        ],
        properties: {
          brand: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          left_lens_prescription: {
            bsonType: "double",
            minimum: -120.0,
            maximum: 0.0,
            description: "must be a double in [-120.0 , 0.0] and is required"
          },
          right_lens_prescription: {
            bsonType: "double",
            minimum: -120.0,
            maximum: 0.0,
            description: "must be a double in [-120.0, 0.0] and is required"
          },
          frame_type: {
            enum: ["Metallic", "Floating", "Acetate"],
            description: "must be one of the enum values and is required"
          },
          frame_color: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          left_lens_color: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          right_lens_color: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          price: {
            bsonType: "double",
            description: "must be a double and is required"
          },
          provider: {
            bsonType: "string",
            description: "must be a string and is required"
          }
        }
      }
    }
  });

  db.createCollection("providers", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: [
          "name", "addresses", "telephone_number", "fax", "NIF"
        ],
        properties: {
          name: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          addresses: {
            bsonType: ["array"],
            description: "array of objects",
            items: {
              bsonType: "object",
              required: [
                "street_type", "street_name", "street_number",
                "floor", "door", "city", "postal_code", "country"
              ],
              properties: {
                street_type: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                street_name: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                street_number: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                floor: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                door: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                city: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                postal_code: {
                  bsonType: "string",
                  description: "must be a string and is required"
                },
                country: {
                  bsonType: "string",
                  description: "must be a string and is required"
                }
              }
            }
          }
        }
      }
    }
  });

  db.createCollection("customers", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        properties: {
          name: {
            bsonType: "string",
            description: "must be a string"
          },
          postal_code: {
            bsonType: "string",
            description: "must be a string"
          },
          telephone_number: {
            bsonType: "string",
            description: "must be a string"
          },
          email: {
            bsonType: "string",
            description: "must be a string"
          },
          registration_date: {
            bsonType: "string",
            description: "must be a string"
          },
          recommended_by: {
            bsonType: ["null", "objectId"],
            description: "can be null or objectId"
          }
        }
      }
    }
  });

  db.createCollection("employees", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: ["name", "surname1", "surname2", "nif", "telephone_number"],
        properties: {
          name: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          surname1: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          surname2: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          nif: {
            bsonType: "string",
            description: "must be a string and is required",
            minLength: 9,
            maxLength: 9
          },
          telephone_number: {
            bsonType: "string",
            description: "must be a string and is required",
            minLength: 9,
            maxLength: 9
          }
        }
      }
    }
  });

  db.createCollection("orders", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: [
          "dt_order_placed", "products", "total_price"
        ],
        properties: {
          dt_order_placed: {
            bsonType: "string",
            description: "must be a string and is required"
          },
          customer_id: {
            bsonType: "objectId",
            description: "must be an objectId and is required"
          },
          provider_id: {
            bsonType: "objectId",
            description: "must be an objectId and is required"
          },
          sold_by: {
            bsonType: "objectId",
            description: "must be an objectId and is required"
          },
          ordered_by: {
            bsonType: "objectId",
            description: "must be an objectId and is required"
          },
          total_price: {
            bsonType: "double",
            description: "must be a double and is required"
          },
          products: {
            bsonType: ["array"],
            description: "array of products and is required",
            items: {
              bsonType: "object",
              required: ["quantity", "product_id", "price_per_unit"],
              properties: {
                quantity: {
                  bsonType: "int",
                  description: "must be an integer and is required"
                },
                product_id: {
                  bsonType: "objectId",
                  description: "must be an objectId and is required"
                },
                price_per_unit: {
                  bsonType: "double",
                  description: "must be a double and is required"
                }
              }
            }
          }
        }
      }
    }
  });

  // // Emulate application behaviour. Insert a customer, the next one gets recommended
  // // by the first one.
  // db.collection("customers").insertOne({
  //   name: "Rosario",
  //   postal_code: "09823",
  //   telephone_number: "908323345",
  //   email: "rosana@gmail.com",
  //   registration_date: new Date("2020-03-12T15:00:00Z"),
  //   recommended_by: null
  // });
  //
  // db.collection("customers").insertOne({
  //   name: "Josep",
  //   postal_code: "09823",
  //   telephone_number: "998923456",
  //   email: "josep@gmail.com",
  //   registration_date: new Date("2020-03-12T15:05:00Z"),
  //   recommended_by: null
  // });

  // db.collection("customers").find(
  //   { telephone_number: "908323345" }, { _id: 1 }
  // ).toArray(function(err, result) {
  //   if (err) {
  //     throw err;
  //   }
  //
  //   console.log(result);
  // });

});
