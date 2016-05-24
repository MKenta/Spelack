import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import { VirtualScroll } from 'react-virtualized';
import 'react-virtualized/styles.css'; // only needs to be imported once
import request from 'superagent';
import shallowCompare from 'react-addons-shallow-compare'
import { callApi } from '../utils'
import Channel from './channel'

var root = window.location.origin;

export default class ChannelList extends Component {
  static propTypes = {
    setChannel: PropTypes.func.isRequired
  }

  constructor (props) {
    super(props)
    this.state = {
      overscanRowsCount: 5,
      rowsCount: 0,
      scrollToIndex: undefined,
      useDynamicRowHeight: false,
      virtualScrollHeight: 300,
      virtualScrollRowHeight: 24,
      list: [],
      selected: undefined
    }

    this.getIndex = this.getIndex.bind(this)
    this.componentDidMount = this.componentDidMount.bind(this)
    this._getRowHeight = this._getRowHeight.bind(this)
    this._noRowsRenderer = this._noRowsRenderer.bind(this)
    this._onRowsCountChange = this._onRowsCountChange.bind(this)
    this._onScrollToRowChange = this._onScrollToRowChange.bind(this)
    this._rowRenderer = this._rowRenderer.bind(this)
    this._updateUseDynamicRowHeight = this._updateUseDynamicRowHeight.bind(this)
  }
  componentDidMount () {
    callApi('channels/index')
    .then(
      (obj) => {
        this.setState({
          list:obj,
          rowsCount:obj.length
        })
      }
    ).catch(
      (err) => { console.error(err); }
    );
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
          width={250}
        />
    )
  }

  shouldComponentUpdate (nextProps, nextState) {
    return shallowCompare(this, nextProps, nextState)
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
        No channels
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
      <Channel
        name = {datum.name}
        id = {datum.id}
        _setChannel = {::this._setChannel}
      />
    )
  }

  _updateUseDynamicRowHeight (value) {
    this.setState({
      useDynamicRowHeight: value
    })
  }

  getIndex (id) {
    var list = this.state.list
    var result = Object.keys(list).filter( (k) => {
     return list[k].id == id
   })[0];
    return result
  }

  _setChannel (channel_id) {
    this.props.setChannel(channel_id)
  }

}
