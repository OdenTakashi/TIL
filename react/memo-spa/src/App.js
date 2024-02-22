import List from './components/List.js'
import { useState } from 'react';

function App() {
  const [memos, setMemos] = useState(JSON.parse(localStorage.getItem("memos")) || [])
  const [isEditable, setIsEditable] = useState(false)
  const [context, setContext] = useState('')


  function saveMemo({serialNumber}) {
    setMemos(
      [
        ...memos,
        {"id": serialNumber, "body": context}
      ]
    )
  }

  function handleEditMode() {
    setContext('')
    setIsEditable(!isEditable)
  }

  function handleFormContent(content) {
    setContext(content)
  }

  return (
    <div className='h-screen'>
      <header className='ml-6 mt-2'>
        <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      </header>
      <List memoItems={memos} editable={isEditable} handleClick={handleEditMode} pushMemo={saveMemo} formContent={context} handleFormContent={handleFormContent}/>
    </div>
  );
}

export default App;
