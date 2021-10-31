import Head from 'next/head';
import { useForm } from 'react-hook-form';

type IForm = {
  name: string;
};

export default function Home(): JSX.Element {
  const { register, handleSubmit, reset } = useForm<IForm>();
  const submit = async (data: IForm) => {
    const res = await fetch('http://127.0.0.1:3001', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    }).then((d) => d.json());
    console.log(res);
    reset();
  };

  return (
    <div className="container">
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <input type="text" {...register('name')} />
      <button onClick={handleSubmit(submit)}>click</button>

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
