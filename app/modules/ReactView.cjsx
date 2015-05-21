React = require('react')

Hello = React.createClass
  render: ->
    <div>Hello, {@props.name}!</div>

# coffeelint: disable=max_line_length
React.render(<Hello name='You' />, document.getElementById('hello'))
# coffeelint: enable=max_line_length

