export default function () {

  const adminNav = document.querySelector('.js-admin-nav');
  const adminNavToggle = document.querySelector('.js-admin-nav-toggle');
  const adminNavIcon = adminNavToggle.querySelector('.js-admin-nav-icon');

  adminNav.classList.add('is-hidden');

  adminNavToggle.addEventListener('click', (e) => {
    e.preventDefault();

    adminNav.classList.toggle('is-hidden');
    toggleNavIcon(adminNavIcon);
  });
}

function toggleNavIcon(icon) {
  const currentRef = icon.firstChild.getAttribute('xlink:href');

  let newPath = '/' + currentRef.substring(1,currentRef.indexOf("#"));

  if (currentRef.includes('#admin-menu')) {
    newPath += '#admin-close-menu';
  } else {
    newPath += '#admin-menu'
  }
  
  icon.firstChild.setAttribute('xlink:href', newPath);
}
