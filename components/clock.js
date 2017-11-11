import PropTypes from "prop-types";
import React from "react";
import { requireNativeComponent } from "react-native";

class ClockView extends React.Component {
  render() {
    return <RNTClock {...this.props} />;
  }
}

ClockView.propTypes = {
  color: PropTypes.string
};

var RNTClock = requireNativeComponent("RNTClock", ClockView);

module.exports = ClockView;
