/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from "react";

import Clock from "./components/clock";

import { Platform, StyleSheet, Text, View } from "react-native";

const instructions = Platform.select({
  ios: "Press Cmd+R to reload,\n" + "Cmd+D or shake for dev menu",
  android:
    "Double tap R on your keyboard to reload,\n" +
    "Shake or press menu button for dev menu"
});

export default class App extends Component<{}> {
  state = {
    color: "#f1f",
    time: new Date()
  };

  componentDidMount() {
    let i = 0;
    const colors = ["#f1f"];

    this.interval = setInterval(
      () =>
        this.setState({
          color: colors[i++ % colors.length],
          time: new Date()
        }),
      0
    );
  }

  render() {
    const { time } = this.state;

    const seconds = time.getSeconds();
    const minute = time.getMinutes();
    const hour = time.getHours();

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <Clock
          secondsColor="#f00"
          minutesColor="#000"
          hoursColor="#000"
          seconds={seconds}
          minute={minute}
          hour={hour}
          style={{
            width: 200,
            height: 200
          }}
        />
        <Text>
          {hour}:{minute}:{seconds}
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#F5FCFF"
  },
  welcome: {
    fontSize: 20,
    textAlign: "center",
    margin: 10
  },
  instructions: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5
  }
});
