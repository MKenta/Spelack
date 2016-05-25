import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import request from 'superagent';
import MessageList from './components/message_list'
import ChannelList from './components/channel_list'

export default class Application extends Component {
  constructor (props) {
    super(props)

    this.state = {
      selected: undefined
    }
  }
  render () {
    return (
      <div>
        <ChannelList
        setChannel = {::this.setChannel}
        />
        {this.state.message_list}
      </div>
      )
  }

  setChannel (channel_id) {
    this.setState({
      selected: channel_id
    })
  }
  componentDidUpdate(nextProps, nextState) {
    if (this.state.selected){
      ReactDOM.render(
        <MessageList
          channel_id = {this.state.selected}
        />,document.getElementById('messages')
      );
    }
  }
}
