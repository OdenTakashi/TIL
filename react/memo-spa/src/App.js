import MemoList from './components/MemoList.js'

function App() {
  const memos = JSON.parse(localStorage.getItem("memos")) || []

  return (
    <div className='h-screen'>
      <header className='ml-6 mt-2'>
        <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      </header>
      <MemoList memoItems={memos}/>
    </div>
  );
}

export default App;
