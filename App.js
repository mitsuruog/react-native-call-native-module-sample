/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View, Button, NativeModules, NativeEventEmitter } from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

const { CalendarManager, Counter } = NativeModules;

const counterEvents = new NativeEventEmitter(Counter);

type Props = {};
type State = { count: number }

export default class App extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state     = {
      count: Counter.initialValue,
    };
    this.getCount  = this.getCount.bind(this);
    this.increment = this.increment.bind(this);
    this.decrement = this.decrement.bind(this);
    this.addEvent  = this.addEvent.bind(this);
  }

  componentWillMount() {
    counterEvents.addListener('onIncrement', ({ count }) => {
      this.setState({ count });
    });
    counterEvents.addListener('onDecrement', ({ count }) => {
      this.setState({ count });
    });
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome 2 React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <Text>{this.state.count}</Text>
        <Button title={'-'} onPress={this.decrement} />
        <Button title={'+'} onPress={this.increment} />
        <Button title={'Get Count'} onPress={this.getCount} />
        <Button title={'Add Event'} onPress={this.addEvent} />
      </View>
    );
  }

  getCount() {
    Counter.getCount(count => this.setState({ count }));
  }

  increment() {
    Counter.increment();
  }

  decrement() {
    Counter.decrement()
      .then(message => console.log(message))
      .catch(error => console.error(error));
  }

  addEvent() {
    CalendarManager.addEvent('Birthday Party', 'My house', new Date().getTime());
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
