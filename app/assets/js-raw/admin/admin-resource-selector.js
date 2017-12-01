import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class ResourceSelector extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      resourceTitle: this.props.resourcetitle
    }
  }

  resetResource(ev) {
    ev.preventDefault();
    this.setSelectedResource('', null);
  }

  setSelectedResource(id, title) {
    this.setState({ resourceTitle: title, resources: null, searchActive: false });
    this.props.onComplete(id);
    const searchBox = document.querySelector('.m-resource-selector__search');
    if (searchBox) {
      searchBox.classList.remove('m-resource-selector__search--active');
    }
  }

  resourceLookup(ev) {

    fetch(`/admin/api/resource?q=${ev.target.value}`, {
      method: 'GET',
      cache: 'no-cache',
      credentials: 'include'
    })
      .then(res => res.json())
      .then(resources => this.setState({ resources: resources, searchActive: true }))
      .catch(error => "")
  }

  toggleSearchFocus(ev) {
    document.querySelector('.m-resource-selector__search').classList.add('m-resource-selector__search--active')
    this.setState({ searchActive: true });
  }

  cancelSearch(ev) {
    ev.preventDefault();
    this.setState({ searchActive: false, resources: null });
    document.querySelector('.m-resource-selector__search').classList.remove('m-resource-selector__search--active')

  }

  render() {
    return (
      <div>
        <div className="form__field m-resource-selector">
          <label className="form__label">Resource parent</label>

          { this.state.resourceTitle ? (
            <p className="m-resource-selector__title">
              {this.state.resourceTitle}
              <button
                className="u-btn u-btn--danger u-btn--mini"
                onClick={this.resetResource.bind(this)}
              >
                Remove
              </button>
            </p>
          ) : (
            <div className="m-resource-selector__search">

              <input
                className="form__input m-resource-selector__search__field"
                type="text"
                placeholder="Search…"
                onFocus={this.toggleSearchFocus.bind(this)}
                onKeyUp={this.resourceLookup.bind(this)}
                />
              
              { this.state.searchActive && ( 
                <button
                  className="u-btn m-resource-selector__search__cancel"
                  onClick={this.cancelSearch.bind(this)}
                >
                  Cancel
                </button>
              )}

              { this.state.resources && (
                <ul className="m-resource-selector__search__results">
                  { this.state.resources.map((res, i) => (
                    <li
                      key={i}
                      onClick={this.setSelectedResource.bind(this, res.id, res.title)}
                    >
                      { res.title }
                    </li>
                  ))}
                </ul>
              )}
            </div>

          )}
        </div>
      </div>
    )
  }
}

ResourceSelector.propTypes = {
  resourcetitle: PropTypes.string,
  onComplete: PropTypes.func.isRequired
}

export default function (el) {
  const container = document.querySelector(el); 
  if (!container) { return; }

  function callback(resource_id) {
    document.getElementById(container.dataset.inputid).value = resource_id;
  }

  ReactDOM.render(
    <ResourceSelector
      {...container.dataset}
      onComplete={callback} />
  , container)

}
