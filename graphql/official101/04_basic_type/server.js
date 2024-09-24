var express = require("express")
var { createHandler } = require("graphql-http/lib/use/express")
var { buildSchema } = require("graphql")
var { ruruHTML } = require("ruru/server")

var schema = buildSchema(`
  type Query {
    quoteOfTheDay: String
    random: Float
    rollThreeDice: [Int]
  }
`)

var root = {
  quoteOfTheDay() {
    return  Math.random() < 0.5 ? "Take it easy" : "Salvation lies within" 
  },
  random() {
    return Math.random()
  },
  rollThreeDice() {
    return [1,2,3].map(_ => 1 + Math.floor(Math.random() * 6))
  }
}

var app = express()

app.all(
  '/graphql',
  createHandler({
    schema: schema,
    rootValue: root,
  })
)

app.get("/", (_req, res) => {
  res.type("html")
  res.end(ruruHTML({ endpoint: "/graphql" }))
})

app.listen(4000)
console.log('Running a GraphQL API server at http://localhost:4000/graphql')
