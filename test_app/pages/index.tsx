import Head from 'next/head';
import { FormEvent, useState, useRef, useEffect } from 'react';

type ITodo = {
  id: string;
  text: string;
};

export default function Home(): JSX.Element {
  const [todos, setTodos] = useState<ITodo[]>([]);
  const [editId, setEditId] = useState<string>();
  const ref = useRef<HTMLInputElement>(null);
  const editRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    (async () => {
      const res = await fetch('http://localhost:3001/read', {
        method: 'GET',
        mode: 'cors',
      });
      const data = await res.json();
      setTodos(data);
    })();
  }, []);

  const customFetch = async (path: string, body: Partial<ITodo>) => {
    try {
      const res = await fetch(`http://localhost:3001/${path}`, {
        method: 'POST',
        mode: 'cors',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      });
      const data = await res.json();
      setTodos(data);
    } catch (error) {
      console.error(error);
    }
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    if (ref.current) {
      if (ref.current.value.trim().length === 0) {
        alert('1文字以上入力してください(スペースを除く)');
        return;
      }
      await customFetch('create', { text: ref.current.value });
      ref.current.value = '';
    }
  };

  const handleUpdate = async (id: string, text: string) => {
    await customFetch('update', { id, text });
    setEditId(undefined);
  };

  const handleDelete = async (id: string) => {
    if (confirm('本当に削除しますか？')) {
      customFetch('delete', { id });
    }
  };

  return (
    <div className="container">
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <form onSubmit={handleSubmit}>
        <input type="text" ref={ref} placeholder="やることを追加" />
        <button type="submit">追加</button>
      </form>
      <ul>
        {todos &&
          todos.map(({ id, text }) => (
            <li key={id}>
              {editId === id ? (
                <>
                  <input type="text" ref={editRef} defaultValue={text} />
                  <button onClick={() => setEditId(undefined)}>
                    キャンセル
                  </button>
                  <button
                    onClick={() => handleUpdate(id, editRef.current.value)}
                  >
                    保存
                  </button>
                </>
              ) : (
                <>
                  <p>{text}</p>
                  <button onClick={() => handleDelete(id)}>削除</button>
                  <button onClick={() => setEditId(id)}>編集</button>
                </>
              )}
            </li>
          ))}
      </ul>
      <style jsx>{`
        .container {
          min-height: 100vh;
          padding: 0 0.5rem;
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
        }
      `}</style>
      <style jsx global>{`
        html,
        body {
          padding: 0;
          margin: 0;
          font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto,
            Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue,
            sans-serif;
        }

        * {
          box-sizing: border-box;
        }
      `}</style>
    </div>
  );
}
