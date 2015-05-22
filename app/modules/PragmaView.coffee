# @cjsx React.DOM

React = require('react')

Goodbye = React.createClass
  render: ->
    <div>Bye, {@props.name}!</div>

# coffeelint: disable=max_line_length
React.render(<Goodbye name='You' />, document.getElementById('goodbye'))
# coffeelint: enable=max_line_length

