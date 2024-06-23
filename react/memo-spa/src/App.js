import List from './components/List'
import EditForm from './components/EditForm'
import Header from './components/Header'
import { useState, useEffect } from 'react'
import { LoginContext } from './context/loginContext'

function App() {
  const [memos, setMemos] = useState(JSON.parse(localStorage.getItem("memos")) || [])
  const [isEditable, setIsEditable] = useState('')
  const [context, setContext] = useState('')
  const [loginStatus, setLoginStatus] = useState(false)

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
      <LoginContext.Provider value={{loginStatus, setLoginStatus}}>
        <Header/>
        <div className='w-1/2 m-auto mt-3 text-xl text-zinc-700 font-semibold'>{runningMode()}</div>
        <List memoItems={memos} handleClick={handleEditMode} handleFormContent={handleFormContent}/>
        <EditForm updateMemo={updateMemo} isEditable={isEditable} memoLists={memos} handleEditMode={handleEditMode} formContent={context} updateContent={updateContent}/>
      </LoginContext.Provider>
    </div>
  );
}

export default App;
