import PropTypes from "prop-types";
import React from "react";
import { requireNativeComponent } from "react-native";

class ClockView extends React.Component {
  render() {
    return <RNTClock {...this.props} />;
  }
}

ClockView.propTypes = {
  secondsColor: PropTypes.string,
  minutesColor: PropTypes.string,
  hoursColor: PropTypes.string,
  seconds: PropTypes.number,
  minute: PropTypes.number,
  hour: PropTypes.number
};

var RNTClock = requireNativeComponent("RNTClock", ClockView);

module.exports = ClockView;
