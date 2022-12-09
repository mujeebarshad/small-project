/*global require:true*/

import "core-js";
import "@stimulus/polyfills";
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import PubSub from "pubsub-js";

const application = Application.start();
const context = require.context("controllers", true, /.js$/);
application.load(definitionsFromContext(context));

PubSub.clearAllSubscriptions();
