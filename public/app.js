(function(){
  const path = location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('nav a').forEach(a=>{
    const href = a.getAttribute('href') || '';
    if ((path === '' && href === 'index.html') || href === path) a.classList.add('active');
  });
})();
