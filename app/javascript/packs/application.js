// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "jquery";
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "popper.js";
import "bootstrap";
import '../stylesheets/application.scss';
import Swiper from 'swiper/swiper-bundle.js';  //この行を追記
import 'swiper/swiper-bundle.css';
//この行を追記
//= require jquery
//= require rails-ujs

import '../features/accordion' //里親募集掲載の検索フォームのアコーディオン機能


Rails.start()
Turbolinks.start()
ActiveStorage.start()

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)