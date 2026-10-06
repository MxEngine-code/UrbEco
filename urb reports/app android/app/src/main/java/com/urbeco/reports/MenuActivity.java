package com.urbeco.reports;

import android.Manifest;
import android.animation.*;
import android.app.*;
import android.app.AlertDialog;
import android.content.*;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.content.res.*;
import android.graphics.*;
import android.graphics.drawable.*;
import android.media.*;
import android.net.*;
import android.net.Uri;
import android.os.*;
import android.text.*;
import android.text.style.*;
import android.util.*;
import android.view.*;
import android.view.View;
import android.view.View.*;
import android.view.animation.*;
import android.webkit.*;
import android.widget.*;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TextView;
import androidx.annotation.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.DialogFragment;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.GenericTypeIndicator;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FileDownloadTask;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.OnProgressListener;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;
import java.io.*;
import java.io.File;
import java.text.*;
import java.util.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.*;
import org.json.*;

public class MenuActivity extends AppCompatActivity {
	
	private FirebaseDatabase _firebase = FirebaseDatabase.getInstance();
	private FirebaseStorage _firebase_storage = FirebaseStorage.getInstance();
	
	private double tipoAs = 0;
	private HashMap<String, Object> map = new HashMap<>();
	private HashMap<String, Object> selecionado = new HashMap<>();
	
	private ArrayList<String> listspinner = new ArrayList<>();
	private ArrayList<HashMap<String, Object>> dados = new ArrayList<>();
	private ArrayList<HashMap<String, Object>> dadosus = new ArrayList<>();
	
	private LinearLayout linear1;
	private LinearLayout linear3;
	private ImageView imageview1;
	private TextView textview1;
	private LinearLayout linear2_menu;
	private LinearLayout linear4_detalhes;
	private Spinner spinner1;
	private ListView listview1;
	private LinearLayout linear10;
	private LinearLayout linear9;
	private ImageView imageview2;
	private LinearLayout linear12_cor_detalhea;
	private LinearLayout linear5;
	private LinearLayout linear6;
	private LinearLayout linear8;
	private TextView textview2;
	private LinearLayout linear7;
	private LinearLayout linear11;
	private TextView textview3;
	private CheckBox checkbox1;
	private ScrollView vscroll1;
	private TextView textview4;
	private Button button2;
	private Button button1;
	
	private AlertDialog.Builder d;
	private DatabaseReference Mensagens = _firebase.getReference("Mensagens");
	private ChildEventListener _Mensagens_child_listener;
	private FirebaseAuth auth;
	private OnCompleteListener<AuthResult> _auth_create_user_listener;
	private OnCompleteListener<AuthResult> _auth_sign_in_listener;
	private OnCompleteListener<Void> _auth_reset_password_listener;
	private OnCompleteListener<Void> auth_updateEmailListener;
	private OnCompleteListener<Void> auth_updatePasswordListener;
	private OnCompleteListener<Void> auth_emailVerificationSentListener;
	private OnCompleteListener<Void> auth_deleteUserListener;
	private OnCompleteListener<Void> auth_updateProfileListener;
	private OnCompleteListener<AuthResult> auth_phoneAuthListener;
	private OnCompleteListener<AuthResult> auth_googleSignInListener;
	
	private StorageReference tste = _firebase_storage.getReference("tste");
	private OnCompleteListener<Uri> _tste_upload_success_listener;
	private OnSuccessListener<FileDownloadTask.TaskSnapshot> _tste_download_success_listener;
	private OnSuccessListener _tste_delete_success_listener;
	private OnProgressListener _tste_upload_progress_listener;
	private OnProgressListener _tste_download_progress_listener;
	private OnFailureListener _tste_failure_listener;
	
	
	@Override
	protected void onCreate(Bundle _savedInstanceState) {
		super.onCreate(_savedInstanceState);
		setContentView(R.layout.menu);
		initialize(_savedInstanceState);
		FirebaseApp.initializeApp(this);
		
		if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED
		|| ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED) {
			ActivityCompat.requestPermissions(this, new String[] {Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1000);
		} else {
			initializeLogic();
		}
	}
	
	@Override
	public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
		super.onRequestPermissionsResult(requestCode, permissions, grantResults);
		if (requestCode == 1000) {
			initializeLogic();
		}
	}
	
	private void initialize(Bundle _savedInstanceState) {
		linear1 = findViewById(R.id.linear1);
		linear3 = findViewById(R.id.linear3);
		imageview1 = findViewById(R.id.imageview1);
		textview1 = findViewById(R.id.textview1);
		linear2_menu = findViewById(R.id.linear2_menu);
		linear4_detalhes = findViewById(R.id.linear4_detalhes);
		spinner1 = findViewById(R.id.spinner1);
		listview1 = findViewById(R.id.listview1);
		linear10 = findViewById(R.id.linear10);
		linear9 = findViewById(R.id.linear9);
		imageview2 = findViewById(R.id.imageview2);
		linear12_cor_detalhea = findViewById(R.id.linear12_cor_detalhea);
		linear5 = findViewById(R.id.linear5);
		linear6 = findViewById(R.id.linear6);
		linear8 = findViewById(R.id.linear8);
		textview2 = findViewById(R.id.textview2);
		linear7 = findViewById(R.id.linear7);
		linear11 = findViewById(R.id.linear11);
		textview3 = findViewById(R.id.textview3);
		checkbox1 = findViewById(R.id.checkbox1);
		vscroll1 = findViewById(R.id.vscroll1);
		textview4 = findViewById(R.id.textview4);
		button2 = findViewById(R.id.button2);
		button1 = findViewById(R.id.button1);
		d = new AlertDialog.Builder(this);
		auth = FirebaseAuth.getInstance();
		
		imageview1.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View _view) {
				if (selecionado.isEmpty()) {
					finishAffinity();
				}
				else {
					linear2_menu.setVisibility(View.VISIBLE);
					linear4_detalhes.setVisibility(View.GONE);
					selecionado.clear();
				}
			}
		});
		
		spinner1.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
			@Override
			public void onItemSelected(AdapterView<?> _param1, View _param2, int _param3, long _param4) {
				final int _position = _param3;
				tipoAs = _position;
				_carregar();
			}
			
			@Override
			public void onNothingSelected(AdapterView<?> _param1) {
				
			}
		});
		
		listview1.setOnItemClickListener(new AdapterView.OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> _param1, View _param2, int _param3, long _param4) {
				final int _position = _param3;
				d.setTitle("UrbEco");
				d.setMessage("Assunto: ".concat(dados.get((int)_position).get("Assunto").toString().concat("\n\nMensagem: ".concat(_Cortar(dados.get((int)_position).get("Mensagem").toString(), 50).concat("...")))));
				d.setPositiveButton("Ver", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface _dialog, int _which) {
						selecionado.clear();
						selecionado = dados.get((int)_position);
						linear4_detalhes.setVisibility(View.VISIBLE);
						linear2_menu.setVisibility(View.GONE);
						textview2.setText(_Cortar(dados.get((int)_position).get("Mensagem").toString(), 13).concat("..."));
						textview3.setText("Assunto: ".concat(dados.get((int)_position).get("Assunto").toString()));
						textview4.setText(dados.get((int)_position).get("Mensagem").toString());
						if (dados.get((int)_position).get("Finalizado").toString().equals("true")) {
							linear12_cor_detalhea.setBackgroundColor(0xFF8BC34A);
							checkbox1.setChecked(true);
						}
						else {
							linear12_cor_detalhea.setBackgroundColor(0xFFEEEEEE);
							checkbox1.setChecked(false);
						}
					}
				});
				if (dados.get((int)_position).get("Finalizado").toString().equals("true")) {
					d.setNegativeButton("NFinalizado", new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface _dialog, int _which) {
							map.put("Finalizado", "false");
							Mensagens.child(dados.get((int)_position).get("Id").toString()).updateChildren(map);
						}
					});
				}
				else {
					d.setNegativeButton("Finalizado", new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface _dialog, int _which) {
							map.put("Finalizado", "true");
							Mensagens.child(dados.get((int)_position).get("Id").toString()).updateChildren(map);
						}
					});
				}
				d.setNeutralButton("Deletar", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface _dialog, int _which) {
						Mensagens.child(dados.get((int)_position).get("Id").toString()).removeValue();
					}
				});
				d.create().show();
			}
		});
		
		imageview2.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View _view) {
				linear2_menu.setVisibility(View.VISIBLE);
				linear4_detalhes.setVisibility(View.GONE);
				selecionado.clear();
			}
		});
		
		button2.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View _view) {
				if (checkbox1.isChecked()) {
					selecionado.put("Finalizado", "true");
					linear12_cor_detalhea.setBackgroundColor(0xFF8BC34A);
				}
				else {
					selecionado.put("Finalizado", "false");
					linear12_cor_detalhea.setBackgroundColor(Color.TRANSPARENT);
				}
				Mensagens.child(selecionado.get("Id").toString()).updateChildren(selecionado);
				SketchwareUtil.showMessage(getApplicationContext(), "Status mudado");
			}
		});
		
		button1.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View _view) {
				Mensagens.child(selecionado.get("Id").toString()).removeValue();
				linear2_menu.setVisibility(View.VISIBLE);
				linear4_detalhes.setVisibility(View.GONE);
				selecionado.clear();
				SketchwareUtil.showMessage(getApplicationContext(), "Excluído com êxito!");
			}
		});
		
		_Mensagens_child_listener = new ChildEventListener() {
			@Override
			public void onChildAdded(DataSnapshot _param1, String _param2) {
				GenericTypeIndicator<HashMap<String, Object>> _ind = new GenericTypeIndicator<HashMap<String, Object>>() {};
				final String _childKey = _param1.getKey();
				final HashMap<String, Object> _childValue = _param1.getValue(_ind);
				_carregar();
			}
			
			@Override
			public void onChildChanged(DataSnapshot _param1, String _param2) {
				GenericTypeIndicator<HashMap<String, Object>> _ind = new GenericTypeIndicator<HashMap<String, Object>>() {};
				final String _childKey = _param1.getKey();
				final HashMap<String, Object> _childValue = _param1.getValue(_ind);
				_carregar();
			}
			
			@Override
			public void onChildMoved(DataSnapshot _param1, String _param2) {
				
			}
			
			@Override
			public void onChildRemoved(DataSnapshot _param1) {
				GenericTypeIndicator<HashMap<String, Object>> _ind = new GenericTypeIndicator<HashMap<String, Object>>() {};
				final String _childKey = _param1.getKey();
				final HashMap<String, Object> _childValue = _param1.getValue(_ind);
				_carregar();
			}
			
			@Override
			public void onCancelled(DatabaseError _param1) {
				final int _errorCode = _param1.getCode();
				final String _errorMessage = _param1.getMessage();
				
			}
		};
		Mensagens.addChildEventListener(_Mensagens_child_listener);
		
		_tste_upload_progress_listener = new OnProgressListener<UploadTask.TaskSnapshot>() {
			@Override
			public void onProgress(UploadTask.TaskSnapshot _param1) {
				double _progressValue = (100.0 * _param1.getBytesTransferred()) / _param1.getTotalByteCount();
				
			}
		};
		
		_tste_download_progress_listener = new OnProgressListener<FileDownloadTask.TaskSnapshot>() {
			@Override
			public void onProgress(FileDownloadTask.TaskSnapshot _param1) {
				double _progressValue = (100.0 * _param1.getBytesTransferred()) / _param1.getTotalByteCount();
				
			}
		};
		
		_tste_upload_success_listener = new OnCompleteListener<Uri>() {
			@Override
			public void onComplete(Task<Uri> _param1) {
				final String _downloadUrl = _param1.getResult().toString();
				
			}
		};
		
		_tste_download_success_listener = new OnSuccessListener<FileDownloadTask.TaskSnapshot>() {
			@Override
			public void onSuccess(FileDownloadTask.TaskSnapshot _param1) {
				final long _totalByteCount = _param1.getTotalByteCount();
				
			}
		};
		
		_tste_delete_success_listener = new OnSuccessListener() {
			@Override
			public void onSuccess(Object _param1) {
				
			}
		};
		
		_tste_failure_listener = new OnFailureListener() {
			@Override
			public void onFailure(Exception _param1) {
				final String _message = _param1.getMessage();
				
			}
		};
		
		auth_updateEmailListener = new OnCompleteListener<Void>() {
			@Override
			public void onComplete(Task<Void> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		auth_updatePasswordListener = new OnCompleteListener<Void>() {
			@Override
			public void onComplete(Task<Void> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		auth_emailVerificationSentListener = new OnCompleteListener<Void>() {
			@Override
			public void onComplete(Task<Void> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		auth_deleteUserListener = new OnCompleteListener<Void>() {
			@Override
			public void onComplete(Task<Void> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		auth_phoneAuthListener = new OnCompleteListener<AuthResult>() {
			@Override
			public void onComplete(Task<AuthResult> task) {
				final boolean _success = task.isSuccessful();
				final String _errorMessage = task.getException() != null ? task.getException().getMessage() : "";
				
			}
		};
		
		auth_updateProfileListener = new OnCompleteListener<Void>() {
			@Override
			public void onComplete(Task<Void> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		auth_googleSignInListener = new OnCompleteListener<AuthResult>() {
			@Override
			public void onComplete(Task<AuthResult> task) {
				final boolean _success = task.isSuccessful();
				final String _errorMessage = task.getException() != null ? task.getException().getMessage() : "";
				
			}
		};
		
		_auth_create_user_listener = new OnCompleteListener<AuthResult>() {
			@Override
			public void onComplete(Task<AuthResult> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		_auth_sign_in_listener = new OnCompleteListener<AuthResult>() {
			@Override
			public void onComplete(Task<AuthResult> _param1) {
				final boolean _success = _param1.isSuccessful();
				final String _errorMessage = _param1.getException() != null ? _param1.getException().getMessage() : "";
				
			}
		};
		
		_auth_reset_password_listener = new OnCompleteListener<Void>() {
			@Override
			public void onComplete(Task<Void> _param1) {
				final boolean _success = _param1.isSuccessful();
				
			}
		};
	}
	
	private void initializeLogic() {
		dados.clear();
		tipoAs = 0;
		listspinner.clear();
		listspinner.add("All");
		listspinner.add("Bug");
		listspinner.add("Ideia");
		listspinner.add("Elogio");
		spinner1.setAdapter(new ArrayAdapter<String>(getBaseContext(), android.R.layout.simple_spinner_dropdown_item, listspinner));
		_carregar();
	}
	
	public void _carregar() {
		Mensagens.addListenerForSingleValueEvent(new ValueEventListener() {
			@Override
			public void onDataChange(DataSnapshot _dataSnapshot) {
				dados = new ArrayList<>();
				try {
					GenericTypeIndicator<HashMap<String, Object>> _ind = new GenericTypeIndicator<HashMap<String, Object>>() {};
					for (DataSnapshot _data : _dataSnapshot.getChildren()) {
						HashMap<String, Object> _map = _data.getValue(_ind);
						dados.add(_map);
					}
				}
				catch (Exception _e) {
					_e.printStackTrace();
				}
				listview1.setAdapter(new Listview1Adapter(dados));
				((BaseAdapter)listview1.getAdapter()).notifyDataSetChanged();
			}
			@Override
			public void onCancelled(DatabaseError _databaseError) {
			}
		});
	}
	
	
	public String _Cortar(final String _texto, final double _n) {
		if (_texto.length() > _n) {
			return _texto.substring((int)(0), (int)(_n));
		}
		else {
			return _texto;
		}
	}
	
	public class Listview1Adapter extends BaseAdapter {
		
		ArrayList<HashMap<String, Object>> _data;
		
		public Listview1Adapter(ArrayList<HashMap<String, Object>> _arr) {
			_data = _arr;
		}
		
		@Override
		public int getCount() {
			return _data.size();
		}
		
		@Override
		public HashMap<String, Object> getItem(int _index) {
			return _data.get(_index);
		}
		
		@Override
		public long getItemId(int _index) {
			return _index;
		}
		
		@Override
		public View getView(final int _position, View _v, ViewGroup _container) {
			LayoutInflater _inflater = getLayoutInflater();
			View _view = _v;
			if (_view == null) {
				_view = _inflater.inflate(R.layout.view_custom1, null);
			}
			
			final LinearLayout linear1 = _view.findViewById(R.id.linear1);
			final TextView textview1 = _view.findViewById(R.id.textview1);
			final TextView textview2 = _view.findViewById(R.id.textview2);
			
			if (listspinner.get((int)(tipoAs)).equals("All")) {
				linear1.setVisibility(View.VISIBLE);
				textview1.setText(_Cortar(_data.get((int)_position).get("Mensagem").toString(), 18).concat("..."));
				textview2.setText("Assunto: ".concat(_data.get((int)_position).get("Assunto").toString()));
			}
			else {
				if (_data.get((int)_position).get("Assunto").toString().equals(listspinner.get((int)(tipoAs)))) {
					linear1.setVisibility(View.VISIBLE);
					textview1.setText(_Cortar(_data.get((int)_position).get("Mensagem").toString(), 18).concat("..."));
					textview2.setText("Assunto: ".concat(_data.get((int)_position).get("Assunto").toString()));
				}
				else {
					linear1.setVisibility(View.GONE);
				}
			}
			if (_data.get((int)_position).get("Finalizado").toString().equals("true")) {
				linear1.setBackgroundColor(0xFF8BC34A);
			}
			else {
				linear1.setBackgroundColor(Color.TRANSPARENT);
			}
			
			return _view;
		}
	}
	
	@Deprecated
	public void showMessage(String _s) {
		Toast.makeText(getApplicationContext(), _s, Toast.LENGTH_SHORT).show();
	}
	
	@Deprecated
	public int getLocationX(View _v) {
		int _location[] = new int[2];
		_v.getLocationInWindow(_location);
		return _location[0];
	}
	
	@Deprecated
	public int getLocationY(View _v) {
		int _location[] = new int[2];
		_v.getLocationInWindow(_location);
		return _location[1];
	}
	
	@Deprecated
	public int getRandom(int _min, int _max) {
		Random random = new Random();
		return random.nextInt(_max - _min + 1) + _min;
	}
	
	@Deprecated
	public ArrayList<Double> getCheckedItemPositionsToArray(ListView _list) {
		ArrayList<Double> _result = new ArrayList<Double>();
		SparseBooleanArray _arr = _list.getCheckedItemPositions();
		for (int _iIdx = 0; _iIdx < _arr.size(); _iIdx++) {
			if (_arr.valueAt(_iIdx))
			_result.add((double)_arr.keyAt(_iIdx));
		}
		return _result;
	}
	
	@Deprecated
	public float getDip(int _input) {
		return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, _input, getResources().getDisplayMetrics());
	}
	
	@Deprecated
	public int getDisplayWidthPixels() {
		return getResources().getDisplayMetrics().widthPixels;
	}
	
	@Deprecated
	public int getDisplayHeightPixels() {
		return getResources().getDisplayMetrics().heightPixels;
	}
}