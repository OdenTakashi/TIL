import List from './components/List.js'
import EditForm from './components/EditForm.js'
import { useState, useEffect } from 'react'

function App() {
  const [memos, setMemos] = useState(JSON.parse(localStorage.getItem("memos")) || [])
  const [isEditable, setIsEditable] = useState('')
  const [context, setContext] = useState('')

  useEffect(() => {
    localStorage.setItem('memos', JSON.stringify(memos))
  }, [memos])

  function updateMemo(memos) {
    setMemos(memos)
  }

  function handleEditMode(number) {
    setContext('')
    setIsEditable(number)
  }

  function handleFormContent({context, number}) {
    setIsEditable(number)
    setContext(context)
  }

  function updateContent(content) {
    setContext(content)
  }

  function runningMode() {
    return isEditable ? '編集中' : '一覧'
  }

  return (
    <div className='h-screen'>
      <header className='ml-6 mt-2'>
        <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      </header>
      <div className='w-1/2 m-auto mt-3 text-xl text-zinc-700 font-semibold'>{runningMode()}</div>
      <List memoItems={memos} handleClick={handleEditMode} handleFormContent={handleFormContent}/>
      <EditForm updateMemo={updateMemo} isEditable={isEditable} memoLists={memos} handleEditMode={handleEditMode} formContent={context} updateContent={updateContent}/>
    </div>
  );
}

export default App;
