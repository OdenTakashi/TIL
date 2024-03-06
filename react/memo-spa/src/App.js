import List from './components/List.js'
import { useState } from 'react';

function App() {
  const [memos, setMemos] = useState(JSON.parse(localStorage.getItem("memos")) || [])
  const [isEditable, setIsEditable] = useState('')
  const [context, setContext] = useState('')


  function saveMemo({serialNumber}) {
    setMemos(
      [
        ...memos,
        {"id": serialNumber, "body": context}
      ]
    )
  }

  function deleteMemo(memoLists) {
    setMemos(memoLists)
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
      <List deleteFunction={deleteMemo} memoItems={memos} editable={isEditable} handleClick={handleEditMode} pushMemo={saveMemo} formContent={context} handleFormContent={handleFormContent} updateContent={updateContent}/>
    </div>
  );
}

export default App;
