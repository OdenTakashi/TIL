import List from './components/List.js'
import EditForm from './components/EditForm.js'
import { useState } from 'react';

function App() {
  const [memos, setMemos] = useState(JSON.parse(localStorage.getItem("memos")) || [])
  const [isEditable, setIsEditable] = useState('')
  const [context, setContext] = useState('')


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

  return (
    <div className='h-screen'>
      <header className='ml-6 mt-2'>
        <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      </header>
      <List memoItems={memos} handleClick={handleEditMode} handleFormContent={handleFormContent}/>
      <EditForm updateMemo={updateMemo} isEditable={isEditable} memoLists={memos} handleEditMode={handleEditMode} formContent={context} updateContent={updateContent}/>
    </div>
  );
}

export default App;
