const express = require('express')
const app = express()

app.use(express.static('public'))

app.get('/', (req, res) => {
	res.send('Web server is online')
})

const server = app.listen(process.env.PORT)

const io = require('socket.io')(server)

io.on('connection', (socket) => {

  console.log('New Connection')

  socket.on('message', (data) => {
    console.log('data' + data)
    console.log(data.username, data.text)
    io.emit('message_receive', data);
  })
})