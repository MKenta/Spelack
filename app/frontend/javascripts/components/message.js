import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import '../../stylesheets/message.css';
import request from 'superagent';

export default class Message extends Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    text: PropTypes.string.isRequired,
    date: PropTypes.any.isRequired,
    name: PropTypes.string.isRequired,
    onDelete: PropTypes.func.isRequired,
    onEdit: PropTypes.func.isRequired
  }
  constructor (props) {
    super(props)

    this.state = {
      hovered: false,
      edit: false
    }
  }
  render () {
    let message_menu
    let main_content = <span className = 'text'>{this.props.text}</span>
    if (this.state.hovered && window.nickname == this.props.name){
      message_menu = <span>
            <button type="button" onClick = {::this._onUpdate}>Edit</button>
            <button type="button" onClick = {::this._onDelete}>Delete</button>
          </span>
    }
    if (this.state.edit){
      main_content = <span>
          <textarea ref="textArea" defaultValue={this.props.text} ></textarea>
          <button onClick={::this._onEdit}>change</button>
      </span>
    }
    return (
      <div className = 'ts-message' onMouseEnter={::this.onMouseEnter} onMouseLeave = {::this.onMouseLeave}>
        <div className='message_gutter'>
            <div className='message_icon'>
            </div>
          </div>
        <div className = 'message_content'>
          <span className = 'nickname'>{this.props.name}</span>
          <span className = 'transmission_time'>{this.props.date}</span>
          <span>{message_menu}</span>
          <div className = 'message_body'>
            {main_content}
          </div>
        </div>
      </div>
      )
  }

  onMouseEnter () {
    this.setState({hovered:true});
  }

  onMouseLeave () {
    this.setState({hovered: false});
  }

  _onUpdate () {
    this.setState({edit: true})
  }
  _onDelete () {
  this.props.onDelete(this.props.id)
  }

  _onEdit (e) {
  this.props.onEdit(this.props.id,this.refs.textArea.value)
    this.setState({edit: false})
  }
}
