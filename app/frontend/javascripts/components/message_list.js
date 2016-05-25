import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import { VirtualScroll } from 'react-virtualized';
import 'react-virtualized/styles.css'; // only needs to be imported once
import request from 'superagent';
import shallowCompare from 'react-addons-shallow-compare'
import { callApi } from '../utils'
import Message from './message'
import MessageForm from './message_form'
var root = window.location.origin;

export default class MessageList extends Component {
    static propTypes = {
    channel_id: PropTypes.number.isRequired
  }

  constructor (props) {
    super(props)

    this.state = {
      overscanRowsCount: 5,
      rowsCount: 0,
      scrollToIndex: undefined,
      useDynamicRowHeight: false,
      virtualScrollHeight: 300,
      virtualScrollRowHeight: 60,
      list: []
    }

    this.onPost = this.onPost.bind(this)
    this.setList = this.setList.bind(this)
    this.getIndex = this.getIndex.bind(this)
    this.editMessage = this.editMessage.bind(this)
    this.deleteMessage = this.deleteMessage.bind(this)
    this.componentDidMount = this.componentDidMount.bind(this)
    this.componentWillReceiveProps = this.componentWillReceiveProps.bind(this)
    this._getRowHeight = this._getRowHeight.bind(this)
    this._noRowsRenderer = this._noRowsRenderer.bind(this)
    this._onRowsCountChange = this._onRowsCountChange.bind(this)
    this._onScrollToRowChange = this._onScrollToRowChange.bind(this)
    this._rowRenderer = this._rowRenderer.bind(this)
    this._updateUseDynamicRowHeight = this._updateUseDynamicRowHeight.bind(this)
  }
  componentDidMount () {
    this.setList(this.props.channel_id)
    this.setupSubscription()
    ReactDOM.render(
          <MessageForm
        onPost = {this.onPost}
      />,document.getElementById('messageform')
      );
  }

  setupSubscription() {
    App.cable.subscriptions.create('MessagesChannel', {
      received(message) {
        return this.updateMessage(message)
      },
      updateMessage: this.updateMessage.bind(this)
    })
  }

  setList (channel_id) {
    request
    .get(root + '/api/messages/show')
    .query({channel_id: channel_id})
    .end(
      (err, res) => {
        this.setState({
          list:JSON.parse(res.text),
          rowsCount:JSON.parse(res.text).length,
          scrollToIndex:JSON.parse(res.text).length-1
        })
      }
    );
  }

  updateMessage(message) {
    if(JSON.parse(message).channel_id == this.props.channel_id){
      this.setState({
        list: this.state.list.concat(JSON.parse(message)),
        rowsCount: this.state.rowsCount + 1,
        scrollToIndex: this.state.rowsCount
      })
    }
  }

  render () {
    const {
      overscanRowsCount,
      rowsCount,
      scrollToIndex,
      useDynamicRowHeight,
      virtualScrollHeight,
      virtualScrollRowHeight,
      list
    } = this.state
    return (
        <VirtualScroll
          ref='VirtualScroll'
          className='VirtualScroll'
          height={virtualScrollHeight}
          overscanRowsCount={overscanRowsCount}
          noRowsRenderer={this._noRowsRenderer}
          rowsCount={rowsCount}
          rowHeight={useDynamicRowHeight ? this._getRowHeight : virtualScrollRowHeight}
          rowRenderer={this._rowRenderer}
          scrollToIndex={scrollToIndex}
          width={600}
        />
    )
  }

  shouldComponentUpdate (nextProps, nextState) {
    return shallowCompare(this, nextProps, nextState)
  }

  componentWillReceiveProps (nextProps) {
    this.setList(nextProps.channel_id)
  }

  _getDatum (index) {
    const list = this.state.list
    return list[(index % list.length)]
  }

  _getRowHeight (index) {
    return this._getDatum(index).length
  }

  _noRowsRenderer () {
    return (
      <div className='No_rows'>
        No rows
      </div>
    )
  }

  _onRowsCountChange (event) {
    const rowsCount = parseInt(event.target.value, 10) || 0

    this.setState({ rowsCount })
  }

  _onScrollToRowChange (event) {
    const { rowsCount } = this.state
    let scrollToIndex = Math.min(rowsCount - 1, parseInt(event.target.value, 10))

    if (isNaN(scrollToIndex)) {
      scrollToIndex = undefined
    }

    this.setState({ scrollToIndex })
  }

  _rowRenderer (index) {
    const { useDynamicRowHeight } = this.state
    let datum = this._getDatum(index)

    return (
      <Message
      id = {datum.id}
      text = {datum.text}
      date = {datum.created_at}
      name = {datum.nickname}
      onDelete = {this.deleteMessage}
      onEdit = {this.editMessage}
      />
    )
  }

  _updateUseDynamicRowHeight (value) {
    this.setState({
      useDynamicRowHeight: value
    })
  }

  deleteMessage (id) {
    this.setState({
      list: this.state.list.filter((message) => {
        return message.id !== id;
      }),
      rowsCount: this.state.list.length-1,
      scrollToIndex: undefined
    });

  request
  .del(root + '/messages/' + id)
  .end(function(err, res){
  });

  }

  getIndex (id) {
    var list = this.state.list
    var result = Object.keys(list).filter( (k) => {
     return list[k].id == id
   })[0];
    return result
  }

  editMessage (id,text) {
  var index = this.getIndex(id)
  var listed = this.state.list
  listed[index].text = text
  this.setState({
    list: listed,
    scrollToIndex: Number(index)
  });

  request
    .put(root + '/messages/' + id)
    .send({text: text})
    .end(function(err, res){
    });
  }

  onPost (text) {
    request
    .post(root + '/messages/')
    .send({text: text,channel_id: this.props.channel_id})
    .end(function(err, res){
    });
  }
}
