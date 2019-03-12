import React from 'react';
import PropTypes from 'prop-types';

export default class NewLocation extends React.Component {

  constructor() {
    super();
    this.state = {
      errors: [],
      status: null
    }
  }

  createLocation(ev) {
    ev.preventDefault();

    // validate

    // API call to add to database
    this.setState({status: 'Saving…'});

    const data = new FormData();
    const uid = ['location', (new Date()).getTime(), 'raw'].join('-');

    data.append('location[name]', document.querySelector('.js-building-name').value);
    data.append('location[address_line_1]', document.querySelector('.js-address_line_1').value);
    data.append('location[address_line_2]', document.querySelector('.js-address_line_2').value);
    data.append('location[city]', document.querySelector('.js-city').value);
    data.append('location[code]', document.querySelector('.js-code').value);

    const token = document.querySelector("meta[name='csrf-token']").content;
    const locationFetch = fetch('/admin/locations', {
      credentials: 'include',
      headers: {
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: data,
      cache: "no-store"
    });

    locationFetch
      .then(res => {
        if (res.status > 300) {
          return res.json()
          .then(json => {
            const err = new Error(json[0]);
            err.res = res;
            throw err;
          });
        }

        return res.json();
      })
      .then(json => {
        this.setState({
          status: 'Complete',
          errors: undefined,
        });
        
        // set selected
        this.props.callback(json);
      })
      .catch(err => {
        this.setState({
          errors: this.state.errors.concat(err.message),
          status: 'Location creation failed'
        });
      });
    
  }

  render() {
    return (
      <div className="r-overlay">

        { this.state.status && (<div>{ this.state.status }</div>)}
        { this.state.errors && (<div>{ this.state.errors }</div>)}

        <div className="form__field form__field--main">
          <label
            className="form__label"
            htmlFor="building_name">
            Building Name
          </label>

          <input
            className="form__input js-building-name"
            name="building_name"
            type="text" />
        </div>

        <div className="form__field form__field--main">
          <label
            className="form__label"
            htmlFor="address_1">
            Address Line 1
          </label>

          <input
            className="form__input js-address_line_1"
            name="address_1"
            type="text" />
        </div>

        <div className="form__field form__field--main">
          <label
            className="form__label"
            htmlFor="address_2">
            Address Line 2
          </label>

          <input
            className="form__input js-address_line_2"
            name="city"
            type="text" />
        </div>

        <div className="form__field form__field--main">
          <label
            className="form__label"
            htmlFor="city">
            City
          </label>

          <input
            className="form__input js-city"
            name="city"
            type="text" />
        </div>

        <div className="form__field form__field--main">
          <label
            className="form__label"
            htmlFor="post_code">
            Post Code
          </label>

          <input
            className="form__input js-code"
            name="post_code"
            type="text" />
        </div>

        <button className="u-btn" onClick={this.createLocation.bind(this)}>Create location</button>

        <a onClick={this.props.cancelCallback.bind(this)}>or cancel</a>
      </div>
    )
  }
}

NewLocation.propTypes = {
  callback: PropTypes.func.isRequired,
  cancelCallback: PropTypes.func.isRequired
}
