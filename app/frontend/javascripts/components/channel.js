import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import '../../stylesheets/channel.css';

export default class Channel extends Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    id: PropTypes.number.isRequired,
    _setChannel: PropTypes.func.isRequired
  }
  constructor (props) {
    super(props)
  }

  render () {
    return (
      <div>
        <button className="channel_button" type="button" href="#" onClick={::this.__setChannel}>{"# " + this.props.name}</button>
      </div>
      )
  }

  __setChannel () {
  this.props._setChannel(this.props.id)
  return false
  }
}
