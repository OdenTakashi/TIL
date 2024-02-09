import MemoList from './components/List.js'
import { useState } from 'react';

function App() {
  const memos = JSON.parse(localStorage.getItem("memos")) || []
  const [isEditable, setIsEditable] = useState(true)

  function saveContent() {
    setIsEditable(!isEditable)
  }
  return (
    <div className='h-screen'>
      <header className='ml-6 mt-2'>
        <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      </header>
      <MemoList memoItems={memos} editable={isEditable} handleClick={saveContent}/>
    </div>
  );
}

export default App;
